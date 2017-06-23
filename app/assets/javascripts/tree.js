var treeData = [], root, tree, svg, i, duration, diagonal, maximum_count;


// fetch data on page load
// $(".tree.index").ready(function(){
//     loadData()
// });

// $(document).ready(function(){
//     alert("tree index ready.");
//     loadData()
// });



var loadData = function(greek_lemma_id) {
    $.ajax({
        type: 'GET',
        contentType: 'application/json; charset=utf-8',
        url: '/tree/index?greek_lemma_id='+greek_lemma_id,
        dataType: 'json',
        success: function (data) {
            console.log("Ajax Call Success!");
            treeData = data;
            build_tree();
        }
    });
};


function build_tree() {
    d3.select("svg").remove();
  var leaves_count = treeData[0].leaves_count;
  maximum_count = parseInt(treeData[0].maximum_count);
  var margin = {top: 20, right: 120, bottom:20, left: 180},
      width= 1700 - margin.right - margin.left,
      height = (leaves_count * 60) - margin.top - margin.bottom;
    i = 0;
    duration = 500;

    tree = d3.layout.tree().size([height, width]);
    diagonal = d3.svg.diagonal().projection(function (d) {
        return [d.y, d.x];
    });
    svg = d3.select('#tree-container')
        .append('svg')
        .attr('width', width + margin.right +margin.left)
        .attr('height', height + margin.top + margin.bottom)
        .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
    root = treeData[0];
    root.x0 = height / 2;
    root.y0 = 0;

    update(root);

    d3.select(self.frameElement).style('height', height+"px");
}

function update(source) {
    var nodes = tree.nodes(root).reverse(),
    links = tree.links(nodes);
    nodes.forEach(function (d) {
        d.y = d.depth * 280;
    });
    var node = svg.selectAll('g.node')
        .data(nodes, function (d) {
            return d.id || (d.id = ++i);
        });

    // Enter any new nodes at the parent's previous position.
    var nodeEnter = node.enter().append("g")
        .attr("class", "node")
        .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; });

    nodeEnter.append("rect")
        .attr("width", 1e-6)
        .attr("height", 1e-6)
        .attr("class", function (d) { return d.class;})
        .on("click", click);


    nodeEnter.append("a")
        .attr("xlink:href", function (d) { return d.url })
        .attr("target", "_blank")
        .append("text")
        .attr("x", function(d) { return d.is_leaf ? 110 : -17; }) // position of text relative to rectangle
        .attr("dy", ".5em")
        .attr("text-anchor", function(d) { return d.is_leaf ? "start" : "end"; })
        .attr("xml:space", "preserve")
        .text(function(d) {return d.name; })
        .style("fill-opacity", 1e-6);

    // Transition nodes to their new position.
    var nodeUpdate = node.transition()
        .duration(duration)
        .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

    nodeUpdate.select("rect")
        .attr("height", 9)
        .attr("width", function(d) {
            if (d.is_leaf)
                return (parseFloat(d.count)/maximum_count * 100);
            else
               return 9;
        });

    nodeUpdate.select(".internal-node")
        .style("fill", function(d) { return d._children ? "#707985" : "#fff"; });

    nodeUpdate.select("text")
        .attr("class", function (d) { return d.text_class ? d.text_class : "default-tree-text"})
        .style("fill-opacity", 1);

    // Transition exiting nodes to the parent's new position.
    var nodeExit = node.exit().transition()
        .duration(duration)
        .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
        .remove();

    nodeExit.select("rect")
        .attr("r", 1e-6);

    nodeExit.select("text")
        .style("fill-opacity", 1e-6);

    // Update the links…
    var link = svg.selectAll("path.link")
        .data(links, function(d) { return d.target.id; });

    // Enter any new links at the parent's previous position.
    link.enter().insert("path", "g")
        .attr("class", "link")
        .attr("d", function(d) {
            var o = {x: source.x0, y: source.y0};
            return diagonal({source: o, target: o});
        });

    // Transition links to their new position.
    link.transition()
        .duration(duration)
        .attr("d", diagonal);

    // Transition exiting nodes to the parent's new position.
    link.exit().transition()
        .duration(duration)
        .attr("d", function(d) {
            var o = {x: source.x, y: source.y};
            return diagonal({source: o, target: o});
        })
        .remove();

    // Stash the old positions for transition.
    nodes.forEach(function(d) {
        d.x0 = d.x;
        d.y0 = d.y;
    });
}

function click(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
  update(d);
}

function collapseAll(){
    root.children.forEach(collapse);
    collapse(root);
    update(root);
}


function collapse(d) {
    if (d.children) {
        d._children = d.children;
        d._children.forEach(collapse);
        d.children = null;
    }
}

function expand(d){
    var children = (d.children)?d.children:d._children;
    if (d._children) {
        d.children = d._children;
        d._children = null;
    }
    if(children)
        children.forEach(expand);
}

function expandAll(){
    expand(root);
    update(root);
}
