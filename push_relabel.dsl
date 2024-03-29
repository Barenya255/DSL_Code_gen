function __push__ (Graph g, node u, node v, propNode <int> excess,propEdge <int> residual_capacity) {
    edge forward_edge = g.get_edge (u, v) ;
    edge backward_edge = g.get_edge (v, u) ;
    int d = min (u.excess, forward_edge.residual_capacity) ;
    u.excess -= d ;
    v.excess += d ;
    forward_edge.residual_capacity -= d ;
    backward_edge.residual_capacity += d ;
    
    push_into_queue (v) ;
}

function relabel (Graph g, node u, propEdge <int> residue, propNode <int> label) {
    
    int new_label = INT_MAX ;
    for (v in g.neighbors (u)) {
        edge residual_capacity = g.get_edge (u, v) ;
        if (residual_capacity.residue > 0) {
            new_label = max (new_label, v) ;
        }
    }
    
    if (new_label < INT_MAX)
        u.label = new_label+1 ;
}

function discharge (Graph g, node u, propNode <int> label, propNode <int> excess, propNode <int> curr_edge, propEdge <int> residue) {
    
    while (u.excess > 0) {
        
        for (v in g.neighbors(u)) {
                       
            edge current_edge = g.get_edge (u,v) ;
            if (u.excess > 0 && current_edge.residue > 0 && u.label == v.label+1) {
                __push__ (g, u, excess, residue) ;     
            }
        }
        
        if (u.excess > 0) {
            relabel (g, u, residue, label) ;
        }
    }
}

