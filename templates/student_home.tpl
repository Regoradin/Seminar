<!doctype html>
<html>
    <div id="root" >
	<h3>Seminar List</h3>
	<div v-for="(seminar, i) in seminars">
	    <{seminar[1]}>
	    <button v-on:click="ChooseSeminar(i)" >Pick Seminar</button>
	</div>
	<h3>Chosen Seminars</h3>
	<draggable v-model="chosen_seminars" >
	    <div v-for="(seminar, i) in chosen_seminars" >
		<{i + 1}> 
		<{seminar[1]}>
		<button v-on:click="UnchooseSeminar(i)" >Remove</button>
	    </div>
	</draggable>

	<form action="student/submit" v-on:submit="CheckSubmit" method="POST" >
	    <input type="text" name ="student_id" value="Student ID" required>
	    
	    
	    <input type="hidden" name="chosen_seminars" v-for="seminar in chosen_seminars" :value="seminar[0]" >
	    <input type="submit" value="Submit Choices" >
	</form>

    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <!-- CDNJS :: Sortable (https://cdnjs.com/) -->
    <script src="//cdn.jsdelivr.net/npm/sortablejs@1.7.0/Sortable.min.js"></script>
    <!-- CDNJS :: Vue.Draggable (https://cdnjs.com/) -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/2.16.0/vuedraggable.min.js"></script>
    <script>

     var app = new Vue
     ({
	 el:'#root',
	 data:{
	     seminars:{{!seminars}},
	     chosen_seminars:[]
	 },
	 delimiters:["<{", "}>"],
	 methods:{
	     ChooseSeminar:function(i)
	     {
		 if(this.chosen_seminars.length < 5){
		     this.chosen_seminars.push(this.seminars[i]);
		     this.seminars.splice(i, 1);
		 }
	     },
	     UnchooseSeminar:function(i)
	     {
		 this.seminars.push(this.chosen_seminars[i]);
		 this.chosen_seminars.splice(i, 1);
	     },
	     CheckSubmit:function(e)
	     {
		 if(this.chosen_seminars.length === 5){
		     return true;
		 }
		 e.preventDefault();
	     }
	 }
     })

    </script>
    
</html>
