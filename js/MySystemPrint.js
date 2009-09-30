(function () {
  
  // A bit hackish: If we don't want to load the rest of MySystem,
  // we can create the namespace seperately:
  MySystem = typeof(MySystem) != 'undefined' ? MySystem : function() {};
  
  
  /**
  * Arrow 'plugin' for Raphael
  **/
  Raphael.fn.arrow = function(startx,starty,endx,endy,len,angle,color) {
    color = typeof(color) != 'undefined' ? color : "#888";
    
    var theta = Math.atan2((endy-starty),(endx-startx));
    var baseAngleA = theta + angle * Math.PI/180;
    var baseAngleB = theta - angle * Math.PI/180;
    var tipX = endx + len * Math.cos(theta);
    var tipY = endy + len * Math.sin(theta);
    var baseAX = endx - len * Math.cos(baseAngleA);
    var baseAY = endy - len * Math.sin(baseAngleA);
    var baseBX = endx - len * Math.cos(baseAngleB);
    var baseBY = endy - len * Math.sin(baseAngleB);
    var pathData = " M " + tipX      + " " + tipY +
                   " L " + baseAX  + " " + baseAY +
                   " L " + baseBX  + " " + baseBY +
                   " Z ";
    return {
      path: this.path({fill: color, stroke: "none"},pathData),
      type: 'arrow'
    };
  };
  
  /**
  * Connection, taken from graffle.js:
  * http://raphaeljs.com/graffle.js  author not cited, part of 
  * rapheal project?  http://raphaeljs.com
  **/
  Raphael.fn.connection = function (obj1, obj2, line, bg) {
      if (obj1.line && obj1.from && obj1.to) {
          line = obj1;
          obj1 = line.from;
          obj2 = line.to;
      }
      var bb1 = obj1.getBBox();
      var bb2 = obj2.getBBox();
      var p = [{x: bb1.x + bb1.width / 2, y: bb1.y - 1},
          {x: bb1.x + bb1.width / 2, y: bb1.y + bb1.height + 1},
          {x: bb1.x - 1, y: bb1.y + bb1.height / 2},
          {x: bb1.x + bb1.width + 1, y: bb1.y + bb1.height / 2},
          {x: bb2.x + bb2.width / 2, y: bb2.y - 1},
          {x: bb2.x + bb2.width / 2, y: bb2.y + bb2.height + 1},
          {x: bb2.x - 1, y: bb2.y + bb2.height / 2},
          {x: bb2.x + bb2.width + 1, y: bb2.y + bb2.height / 2}];
      var d = {}, dis = [];
      
      for (var i = 0; i < 4; i++) {
          var dx, dy;
          for (var j = 4; j < 8; j++) {
                  dx = Math.abs(p[i].x - p[j].x);
                  dy = Math.abs(p[i].y - p[j].y);
              if ((i == j - 4) || (((i != 3 && j != 6) || p[i].x < p[j].x) && ((i != 2 && j != 7) || p[i].x > p[j].x) && ((i != 0 && j != 5) || p[i].y > p[j].y) && ((i != 1 && j != 4) || p[i].y < p[j].y))) {
                  dis.push(dx + dy);
                  d[dis[dis.length - 1]] = [i, j];  
              }
          }
      }
      var res;
      if (dis.length == 0) {
          res = [0, 4];
      } else {
          res = d[Math.min.apply(Math, dis)];
      }
      var x1 = p[res[0]].x,
          y1 = p[res[0]].y,
          x4 = p[res[1]].x,
          y4 = p[res[1]].y,
          dx = Math.max(Math.abs(x1 - x4) / 2, 10),
          dy = Math.max(Math.abs(y1 - y4) / 2, 10),
          x2 = [x1, x1, x1 - dx, x1 + dx][res[0]].toFixed(3),
          y2 = [y1 - dy, y1 + dy, y1, y1][res[0]].toFixed(3),
          x3 = [0, 0, 0, 0, x4, x4, x4 - dx, x4 + dx][res[1]].toFixed(3),
          y3 = [0, 0, 0, 0, y1 + dy, y1 - dy, y4, y4][res[1]].toFixed(3);
      var path = ["M", x1.toFixed(3), y1.toFixed(3), "C", x2, y2, x3, y3, x4.toFixed(3), y4.toFixed(3)].join(",");
      if (line && line.line) {
          line.bg && line.bg.attr({path: path});
          line.line.attr({path: path});
      } else {
          var color = typeof line == "string" ? line : "#000";
          var strokeWidth = bg.split("|")[1] || 3;
          var stroke = bg.split("|")[0];
          return {
              bg: bg && bg.split && this.path({stroke: stroke, fill: "none", "stroke-width": strokeWidth}, path),
              line: this.path({stroke: color, fill: "none"}, path),
              arrow: this.arrow(x3,y3,x4,y4,strokeWidth * 2.0,50,color),
              from: obj1,
              to: obj2
          };
      }
  };
  
  
  
  /**
  * @constructor for Node
  **/
  MySystem.Node = function() {
    this.terminals = [];
    this.icon = [];
    this.x = 0;
    this.y = 0;
  
  };

  /**
  * @method terminal
  * finds the named terminal in this node
  * @param name of terminal to find
  * @returns 'undefined' or the terminal
  **/
  MySystem.Node.prototype.terminal = function(name) {
    var returnVal = null;
    this.terminals.each(function(term){
      if (term.name == name) {
        returnVal = term;
      }
    });
    return returnVal;
  };
  
  /**
  *
  **/
  MySystem.Node.importJson = function(jsonText,contentBaseUrl) {
    var objs = eval(jsonText);
    var nodes = [];
    var wires = [];
    if (objs) {
      objs[0].containers.each(function(container) {
        var node = new MySystem.Node();
        if (typeof(contentBaseUrl) != 'undefined') {
          node.icon = contentBaseUrl + "/" + container.icon;
        }
        else {
          node.icon = container.icon;
        }
        node.x = (container.position[0].replace("px","")) / 1;
        node.y = (container.position[1].replace("px","")) / 1;
        node.name = container.name;
      
        node.terminals = container.terminals;
        nodes.push(node);
      });
    }
    return nodes;
  };
  
  
  
  /**
  * @constructor for Wire
  **/
  MySystem.Wire = function() {
    this.source = null;
    this.target = null;
    this.x = 0;
    this.y = 0;
  };

  /**
  * @method importJson
  * creates wires from json text
  **/
  MySystem.Wire.importJson = function(jsonText,nodes) {
    var objs = eval(jsonText);
    var wires = [];
    if (objs) {
      objs[0].wires.each(function(w) {
        var wire = new MySystem.Wire();
        wire.src = w.src;
        wire.sourceNode = nodes[w.src.moduleId];
        wire.sourceTerminal = wire.sourceNode.terminal(w.src.terminal);
        
        wire.tgt = w.tgt;
        wire.targetNode = nodes[w.tgt.moduleId];
        wire.targetTerminal = wire.targetNode.terminal(w.tgt.terminal);
        
        wire.options = w.options;
        wire.fields = w.options.fields;
        wire.width = wire.fields.width;
        wire.name = wire.fields.name;
        wire.color = w.options.color;
        wire.color.name = wire.fields.color;
        
        // do the drawing for the wire 
        wires.push(wire);
      });
    }
    return wires;
  };
  
    
  /**
  * @constructor
  **/
  MySystemPrint = function(_json,dom_id,contentBaseUrl,width,height,scale_factor) {
    this.data = _json;
    this.name = "my print";
    this.scale =typeof(scale_factor) != 'undefined' ? scale_factor : 0.6;
    this.graphics = Raphael(document.getElementById(dom_id),width,height);
    this.nodes = MySystem.Node.importJson(_json,contentBaseUrl);
    this.wires = MySystem.Wire.importJson(_json,this.nodes);
    this.visContent = this.graphics.set();
    var self = this;
    
    this.nodes.each(function(node) {
      self.drawNode(node);
      self.visContent.push(node.rep);
    });
    
    this.wires.each(function(wire) {
      self.drawWire(wire);
      self.visContent.push(wire.rep);
    });
    this.wrapper = this.graphics;
  };
  
  /**
  * @method drawNode
  **/
  MySystemPrint.prototype.drawNode = function(node) {
    node.rep = this.graphics.set();
    var x = node.x * this.scale;
    var y = node.y * this.scale;
    var size = 50 * this.scale;
    node.rep.push(this.graphics.image(node.icon,x,y,size,size)); // TODO: Fixed size==BAD
    var txt = this.graphics.text(x-10,y,node.name);
    txt.rotate(-90,true);
    node.rep.push(txt);
  };
  
  /**
  * @method drawWire
  * IMPORTANT!!!!! This must be called *after* a call to drawNode. (HACKY-BAD)
  **/
  MySystemPrint.prototype.drawWire = function(wire) {
    wire.rep = this.graphics.connection(wire.sourceNode.rep,wire.targetNode.rep,wire.color,wire.color + "|" + (wire.width * this.scale));
    
    var srcX = wire.sourceNode.x, 
        srcY = wire.sourceNode.y,
        tgtX = wire.targetNode.x,
        tgtY = wire.targetNode.y;
    
    var xDist = ( tgtX - srcX ) / 2;
    var yDist = ( tgtY - srcY ) / 2;

    var realX = ( srcX + xDist ) * this.scale,
        realY = ( srcY + yDist ) * this.scale;
    
    var txt = this.graphics.text( realX, realY, wire.name );
   
    //txt.rotate(-90,true);
    
    // wire.rep.push(txt);
  }
  

}());