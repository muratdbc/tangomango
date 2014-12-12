
// VIEW
var TableView= function(){
  this.table="tbody";
  this.otherRow="tbody tr"
}

TableView.prototype ={
  buildTableFirstRow: function(){
    $(this.table).append('<tr><td class="col-md-1">Monday</td><td class="col-md-1">Tuesday</td><td class="col-md-1">Wednesday</td><td class="col-md-1">Thursday</td><td class="col-md-1">Friday</td><td class="col-md-1">Satruday</td><td class="col-md-1">Sunday</td></tr>');
  },
  appendToRow: function(row){
    $(this.table).append('<tr>'+row+'</tr>');
  }

}

// CONTROLLER
var Controller = function(params){
  this.tableView=params.tableView;
  this.model=params.model;
}

Controller.prototype ={
  bindEvents: function(){
    $("#collapseOne").on("click",function(event){
      // finish this
      this.tableView.updateTable();

    }.bind(this));
     $("#collapseOne").on("click",function(event){

     }.bind(this));
  },
  fetchEvents: function(){
    $.ajax({type:"post",url:"/show-all-venues"}).done(function(all_event_data){
      this.model.events=all_event_data
      $(".overlay").fadeOut("slow",function(){
        this.remove();
      });
      this.updateTable();

    }.bind(this));
  },
   buildTableOtherRow: function(model){
    for (var key in this.model.events){
    this.tableView.appendToRow('<td><div>'+this.model.tangoEventNames()[i]+'</div></td>');
    // $(this.table).append('<div>'+this.model.tangoEventNames+'div');
    }
  },
  updateTable: function(){
    this.tableView.buildTableFirstRow();
    this.buildTableOtherRow();
  }

}

// MODEL

var Model= function(){
  this.events=[];
  this.currentPosition=0;
  this.tangoNames=[]
}
Model.prototype ={
  addEvent: function(tango){
    this.events.push(tango);
  },
  tangoEventNames: function(){
    debugger
    for(var i=0;i<this.events.length;i++){
      this.tangoNames.push(this.events[i].address);
    }
    return this.tangoNames;
  },
  removeEvent: function(tango){
    this.events.splice(index,1);
  },
   pickEvent: function(tango){
    return this.events[index];
  },
   getNextEvent: function(tango){
    if(this.currentPosition < this.events.length-1)
      this.currentPosition++;
    return this.events[this.currentPosition];
  },
   getCurrentEvent: function(){
    return this.events[this.currentPosition];
  }
}

//LAUNCH APP
$(document).ready(function(){

  controller= new Controller({
    tableView : new TableView(),
    model: new Model(),

  })
  var overlay = '<div class="overlay">' +
            '<img class="loading" src="http://bit.ly/1uqnDC5">' +
            '</div>';
  $(overlay).appendTo('body');
  controller.fetchEvents();
  controller.bindEvents();
})


