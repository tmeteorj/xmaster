package cn.edu.tju.bigdata.biz.networks;

import cn.edu.tju.bigdata.entity.networks.Communities;
import org.ujmp.core.graphmatrix.GraphMatrix;

/**
 * Created by Ethan on 2016/10/6.
 */
public interface CommunityDetector {

    Communities<?> communityDetect (GraphMatrix<?, Double> graphMatrix, int k);

}
