package cn.edu.tju.bigdata.entity.networks;

import org.ujmp.core.graphmatrix.GraphMatrix;

import java.util.*;

/**
 * Created by Ethan on 2016/10/6.
 */
public class Communities<N> {

    private GraphMatrix<N, Double> graphMatrix;

    private Map<Integer, Integer> mapOfNodeCommunity = new HashMap<Integer, Integer>();

    private Map<Integer, Set<Integer>> mapOfCommunityNodes = new HashMap<Integer, Set<Integer>>();

    public Communities(GraphMatrix<N, Double> graphMatrix) {
        this.graphMatrix = graphMatrix;
    }

    public void setCommunity (int nodeIndex, int communityIndex) {
        int nmbOfNodes = graphMatrix.getNodeCount();
        if (nodeIndex >= nmbOfNodes) {
            throw new RuntimeException("accessed node " + nodeIndex + ", but only " + nmbOfNodes
                    + " available");
        }
        mapOfNodeCommunity.put(nodeIndex, communityIndex);
        Set<Integer> set = mapOfCommunityNodes.get(communityIndex);
        if (set == null) {
            set = new HashSet<Integer>();
            mapOfCommunityNodes.put(communityIndex, set);
        }
        set.add(nodeIndex);
    }

    public int getCommunityIndex (int nodeIndex){
        Integer communityIndex =  mapOfNodeCommunity.get(nodeIndex);
        if (communityIndex == null)
            return -1;
        return communityIndex;
    }

    public int getCommunityIndex (N node){
        long nodeIndex = graphMatrix.getIndexOfNode(node);
        return getCommunityIndex((int) nodeIndex);
    }

    public int getCommunitySize (int communityIndex){
        int nmbOfCommunities = mapOfCommunityNodes.keySet().size();
        if (communityIndex >= nmbOfCommunities) {
            throw new RuntimeException("accessed community " + communityIndex + ", but only " + nmbOfCommunities
                    + " available");
        }
        return mapOfCommunityNodes.get(communityIndex).size();
    }

    public int getCommunityCount(){
        return mapOfCommunityNodes.keySet().size();
    }

    public List<Integer> getCommunitiesOrderBySize(){
        class Pair implements Comparable<Pair>{
            int communityIndex;
            int size;
            @Override
            public int compareTo(Pair o) {
                return o.size - this.size;
            }
        }
        List<Pair> list = new ArrayList<Pair>();
        for (Integer cIndex : mapOfCommunityNodes.keySet()){
            int size = mapOfCommunityNodes.get(cIndex).size();
            Pair pair = new Pair();
            pair.communityIndex = cIndex;
            pair.size = size;
            list.add(pair);
        }
        Collections.sort(list);
        List<Integer> retList = new ArrayList<Integer>();
        for (Pair pair : list){
            retList.add(pair.communityIndex);
        }
        return retList;
    }

    public GraphMatrix<N, Double> getGraphMatrix() {
        return graphMatrix;
    }
}