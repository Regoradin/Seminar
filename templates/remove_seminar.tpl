<!doctype html>
<html>
    <div id="root">
	<div v-for="seminar in seminars">
	    <span><{seminar[1]}></span>
	    <button v-on:click="RemoveSeminar(seminar[0])">Remove</button>
	</div>

	<form action="remove"  method="POST">
	    <input type="hidden" v-for= "seminar in removed_sems" name="removed" :value="seminar" >
	    <input type="submit" name="save" value="save">
	</form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script>
     var app = new Vue
     ({
	 el:'#root',
	 data:{
	     seminars:{{!seminars}},
	     removed_sems:[]
	 },
	 delimiters: ["<{", "}>"],
	 methods:{
	     RemoveSeminar:function(id){
		 for(i=0; i < this.seminars.length; i++){
		     if(this.seminars[i][0] === id){
			 this.seminars.splice(i, 1);
		     }
		 };
		 this.removed_sems.push(id);
	     }
	 }
     });
     
    </script>
    
</html>
