const d3 = import('d3.js');
// URL: https://observablehq.com/@d3/chord-dependency-diagram
// Title: Chord Dependency Diagram
// Author: D3 (@d3)
// Version: 95
// Runtime version: 1

const m0 = {
  id: "7658b4d9887cc334@95",
  variables: [
    {
      inputs: ["md"],
      value: (function(md){return(
md`# Chord Dependency Diagram

This [chord diagram](/@mbostock/d3-chord-diagram) shows dependencies among a software class hierarchy. Although it does not reveal class-level detail, as [hierarchical edge bundling](/@mbostock/d3-hierarchical-edge-bundling) does, it conveys the total number of imports between and within packages. Note, for example, the circular dependency between *vis.data* and *vis.events*.`
)})
    },
    {
      name: "chart",
      inputs: ["d3","DOM","width","height","chord","data","color","arc","innerRadius","ribbon"],
      value: (function(d3,DOM,width,height,chord,data,color,arc,innerRadius,ribbon)
{
  const svg = d3.select(DOM.svg(width, height))
      .attr("viewBox", [-width / 2, -height / 2, width, height])
      .attr("font-size", 10)
      .attr("font-family", "sans-serif")
      .style("width", "100%")
      .style("height", "auto");

  const chords = chord(data.matrix);

  const group = svg.append("g")
    .selectAll("g")
    .data(chords.groups)
    .join("g");

  group.append("path")
      .attr("fill", d => color(d.index))
      .attr("stroke", d => color(d.index))
      .attr("d", arc);

  group.append("text")
      .each(d => { d.angle = (d.startAngle + d.endAngle) / 2; })o

      .attr("dy", ".35em")
      .attr("transform", d => `
        rotate(${(d.angle * 180 / Math.PI - 90)})
        translate(${innerRadius + 26})
        ${d.angle > Math.PI ? "rotate(180)" : ""}
      `)
      .attr("text-anchor", d => d.angle > Math.PI ? "end" : null)
      .text(d => data.nameByIndex.get(d.index));

  svg.append("g")
      .attr("fill-opacity", 0.67)
    .selectAll("path")
    .data(chords)
    .join("path")
      .attr("stroke", d => d3.rgb(color(d.source.index)).darker())
      .attr("fill", d => color(d.source.index))
      .attr("d", ribbon);

  return svg.node();
}
)
    },
    {
      name: "data",
      inputs: ["d3"],
      value: (async function(d3)
{
  const imports = await d3.json("https://gist.githubusercontent.com/mbostock/1044242/raw/3ebc0fde3887e288b4a9979dad446eb434c54d08/flare.json");

  const indexByName = new Map;
  const nameByIndex = new Map;
  const matrix = [];
  let n = 0;

  // Returns the Flare package name for the given class name.
  function name(name) {
    return name.substring(0, name.lastIndexOf(".")).substring(6);
  }

  // Compute a unique index for each package name.
  imports.forEach(d => {
    if (!indexByName.has(d = name(d.name))) {
      nameByIndex.set(n, d);
      indexByName.set(d, n++);
    }
  });

  // Construct a square matrix counting package imports.
  imports.forEach(d => {
    const source = indexByName.get(name(d.name));
    let row = matrix[source];
    if (!row) row = matrix[source] = Array.from({length: n}).fill(0);
    d.imports.forEach(d => row[indexByName.get(name(d))]++);
  });

  return {
    matrix,
    indexByName,
    nameByIndex
  };
}
)
    },
    {
      name: "chord",
      inputs: ["d3"],
      value: (function(d3){return(
d3.chord()
    .padAngle(.04)
    .sortSubgroups(d3.descending)
    .sortChords(d3.descending)
)})
    },
    {
      name: "arc",
      inputs: ["d3","innerRadius"],
      value: (function(d3,innerRadius){return(
d3.arc()
    .innerRadius(innerRadius)
    .outerRadius(innerRadius + 20)
)})
    },
    {
      name: "ribbon",
      inputs: ["d3","innerRadius"],
      value: (function(d3,innerRadius){return(
d3.ribbon()
    .radius(innerRadius)
)})
    },
    {
      name: "color",
      inputs: ["d3"],
      value: (function(d3){return(
d3.scaleOrdinal(d3.schemeCategory10)
)})
    },
    {
      name: "outerRadius",
      inputs: ["width","height"],
      value: (function(width,height){return(
Math.min(width, height) * 0.5
)})
    },
    {
      name: "innerRadius",
      inputs: ["outerRadius"],
      value: (function(outerRadius){return(
outerRadius - 124
)})
    },
    {
      name: "width",
      value: (function(){return(
964
)})
    },
    {
      name: "height",
      inputs: ["width"],
      value: (function(width){return(
width
)})
    },
    {
      name: "d3",
      inputs: ["require"],
      value: (function(require){return(
require("d3@5")
)})
    }
  ]
};

const notebook = {
  id: "7658b4d9887cc334@95",
  modules: [m0]
};

export default notebook;
