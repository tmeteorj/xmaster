package cn.edu.tju.bigdata.biz.networks;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.ujmp.core.Matrix;
import org.ujmp.core.graphmatrix.DefaultGraphMatrix;
import org.ujmp.core.graphmatrix.GraphMatrix;

import java.util.*;

/**
 * Created by Administrator on 2016/10/6.
 */
@Service
public class GraphMatrixFactory<N> {

    private Map<Integer, GraphMatrix<N, Double>> networksForDifferentThresholds = new HashMap<Integer, GraphMatrix<N, Double>>();

    private GraphMatrix<N, Double> originGraph = new DefaultGraphMatrix<N, Double>();

    public void setEdge(double edge, N node1, N node2) {
        Double originEdge = originGraph.getEdge(node1, node2);
        if (originEdge == null){
            originGraph.setEdge(edge, node1, node2);
        } else {
            originGraph.setEdge(edge + originEdge, node1, node2);
        }
    }

    public GraphMatrix<N, Double> getMatrixByThreshold(){
        return getMatrixByThreshold(0);
    }

    public GraphMatrix<N, Double> getMatrixByThreshold(int threshold){
//        GraphMatrix<N, Double> matrix = networksForDifferentThresholds.get(threshold);
        GraphMatrix<N, Double> matrix = null;
        if (matrix == null) {
            matrix = new DefaultGraphMatrix<N, Double>();
            Iterator<long[]> iterator = originGraph.availableCoordinates().iterator();
            while (iterator.hasNext()){
                long[] coord = iterator.next();
                Assert.isTrue(coord.length == 2, "must be 2D!");
                double edge = originGraph.getEdge(coord[0], coord[1]);
                if (edge <= threshold) continue;
                N node1 = originGraph.getNode(coord[0]);
                N node2 = originGraph.getNode(coord[1]);
                if (node1 == null || node2 == null) continue;
                matrix.setEdge(1.0, node1, node2);
                matrix.setEdge(1.0, node2, node1); // 默认无向图
            }
            networksForDifferentThresholds.put(threshold, matrix);
        }
        return getGiantComponent(matrix);
    }

    private GraphMatrix<N, Double> getGiantComponent (GraphMatrix matrix) {
        GraphMatrix<N, Double> gcMatrix = new DefaultGraphMatrix<N, Double>();
        Iterator<long[]> iterator = matrix.availableCoordinates().iterator();
        List<HashSet<N>> list = new ArrayList<HashSet<N>>();
        while (iterator.hasNext()) {
            long[] coord = iterator.next();
            Assert.isTrue(coord.length == 2, "must be 2D!");
            N node1 = originGraph.getNode(coord[0]);
            N node2 = originGraph.getNode(coord[1]);
            boolean contains = false;
            for (HashSet<N> set : list){
                if (set.contains(node1)){
                    set.add(node2);
                    contains = true;
                } else if (set.contains(node2)){
                    set.add(node1);
                    contains = true;
                }
            }
            if (!contains){
                HashSet<N> hashSet = new HashSet<N>();
                hashSet.add(node1);
                hashSet.add(node2);
                list.add(hashSet);
            }
        }
        boolean[] visited = new boolean[list.size()];
        Set<N> result = new HashSet<N>();
        for (int i=0;i<list.size();i++){
            if (visited[i]) continue;
            for (int j=i+1;j<list.size();j++){
                if (visited[j]) continue;
                result.addAll(list.get(i));
                result.retainAll(list.get(j));
                if (result.size()>0){
                    list.get(i).addAll(list.get(j));
                    visited[j] = true;
                }
            }
        }

        Set<N> maxSet = null;
        int max = -1;
        for (int i=0;i<list.size();i++) {
            if (visited[i]) continue;
            if (list.get(i).size() > max){
                maxSet = list.get(i);
                max = maxSet.size();
            }
        }

        iterator = matrix.availableCoordinates().iterator();
        while (iterator.hasNext()) {
            long[] coord = iterator.next();
            Assert.isTrue(coord.length == 2, "must be 2D!");
            N node1 = originGraph.getNode(coord[0]);
            N node2 = originGraph.getNode(coord[1]);
            if (!maxSet.contains(node1) && !maxSet.contains(node2)) continue;
            gcMatrix.setEdge(1.0, node1, node2);
            gcMatrix.setEdge(1.0, node2, node1);
        }
        return gcMatrix;
    }

    public void clear(){
        this.originGraph.clear();
        this.networksForDifferentThresholds.clear();
    }

}
