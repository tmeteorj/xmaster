package cn.edu.tju.bigdata.biz.networks;

import cn.edu.tju.bigdata.entity.networks.Communities;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.ujmp.core.DenseMatrix;
import org.ujmp.core.Matrix;
import org.ujmp.core.calculation.Calculation;
import org.ujmp.core.graphmatrix.DefaultGraphMatrix;
import org.ujmp.core.graphmatrix.GraphMatrix;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ethan on 2016/10/5.
 */
@Service("nmf")
public class NMF implements CommunityDetector {
    /**
     * 迭代次数
     */
    private static final int CNT_ITER = 100;
    /**
     * 阈值
     */
    private static final double EPS = 1e-6;
    private static Logger logger = LoggerFactory.getLogger(NMF.class);
    private static boolean isLogEnabled = false;

    private static CDResult cdnmf(Matrix A, int k) {
        Assert.isTrue(A.getColumnCount() == A.getRowCount(), "Matrix must be square!");
        long numNodes = A.getColumnCount();
        Matrix U; // n by k
        Matrix H; // k by k
        Matrix X = DenseMatrix.Factory.rand(numNodes, k);
        List<Double> l = new ArrayList<Double>();
        l.add(Double.MAX_VALUE);
        for (int i = 1; i <= CNT_ITER; i++) {
            Matrix up = A.mtimes(X);
            Matrix down = X.times(2).mtimes(X.transpose()).mtimes(X);
            X = X.times(up.divide(down).plus(0.5));
            if (isLogEnabled) {
                l.add(
                        (A.minus(X.mtimes(X.transpose())).transpose()
                                .mtimes(
                                        (A.minus(X.mtimes(X.transpose())))
                                )
                        ).trace()
                );
                if (Math.abs(l.get(l.size() - 1) - l.get(l.size() - 2)) < EPS)
                    break;
            }
            if (i % 100 == 0)
                logger.info(String.format("iteration number %d.", i));
        }
        Matrix colSumX = X.sum(Calculation.Ret.NEW, Matrix.ROW, true);
        U = X.mtimes(
                Matrix.Factory.ones(1, k).divide(colSumX).transpose().diag(Calculation.Ret.NEW)
        );
        H = colSumX.power(Calculation.Ret.NEW, 2).transpose().diag(Calculation.Ret.NEW);
        CDResult cdResult = new CDResult();
        cdResult.H = H;
        cdResult.U = U;
        cdResult.X = X;
        l.remove(0);
        cdResult.objectFunctionValues = l;
        logger.info("run algorithm success!");
        return cdResult;
    }

    public static void main(String[] a) {
        Matrix matrix = DenseMatrix.Factory.zeros(2, 3);
        matrix.setAsDouble(2, 0, 0);
        matrix.setAsDouble(4, 1, 1);
//        matrix.power(Calculation.Ret.NEW, 2).showGUI();
//        Matrix.Factory.ones(1,3).divide(matrix.sum(Calculation.Ret.NEW, Matrix.ROW, true)).transpose().diag(Calculation.Ret.NEW).showGUI();
//        Matrix.Factory.eye(3,3).showGUI();
//        Matrix.Factory.eye(3,3).divide(matrix.sum(Calculation.Ret.NEW, Matrix.ROW, true).transpose().diag(Calculation.Ret.NEW)).showGUI();
        System.out.println(matrix.getColumnCount());
        System.out.println(matrix.getRowCount());
        DefaultGraphMatrix<String, Double> matrix1 = new DefaultGraphMatrix<>();
        matrix1.setEdge(1.0, "a", "b");
        matrix1.setEdge(1.0, "a", "c");
        matrix1.setEdge(1.0, "b", new String("a"));
        matrix1.setEdge(1.0, "c", "a");
        matrix1.setDirected(false);
//        NMF.cdnmf(matrix1, 3);
        Matrix m1 = DenseMatrix.Factory.ones(2, 3);
        Matrix m2 = DenseMatrix.Factory.ones(3, 2);
        m2 = m2.times(2);
        System.out.println(m2);
        System.out.println(m1.mtimes(m2));
    }

    @Override
    public Communities<?> communityDetect(GraphMatrix<?, Double> graphMatrix, int k) {
        CDResult cdResult = cdnmf(graphMatrix, k);
        Communities<?> communities = new Communities<>(graphMatrix);
        getCommunitiesByX(cdResult.X, communities);
        return communities;
    }

    private void getCommunitiesByX(Matrix X, Communities<?> communities) {
        long row = X.getRowCount();
        long col = X.getColumnCount();
        for (int i = 0; i < row; i++) {
            double max = -1.0;
            int communityIndex = -1;
            for (int j = 0; j < col; j++) {
                if (X.getAsDouble(i, j) > max) {
                    max = X.getAsDouble(i, j);
                    communityIndex = j;
                }
            }
            communities.setCommunity(i, communityIndex);
        }
    }

    public static class CDResult {
        public Matrix U, H, X;
        public List<Double> objectFunctionValues;
    }
}
