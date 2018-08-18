<!doctype html>
<html>
    <div id="root" >
	

	<form action="student/submit" v-on:submit="CheckSubmit" method="POST" >
	    <h3>Seminar List</h3>
	    <div v-for="(seminar, i) in seminars">
		<{seminar[1]}>
		<input type="number"  :name="'seminar_' + seminar[0]" value="0" min="0" v-on:change="UpdateRanking($event, seminar)">
	    </div>

	    <input type="text" name ="student_id" value="Student ID" required>
	    
	    
	    <input type="submit" value="Submit Choices" >
	    <input type="reset" value="Reset Rankings" >
	</form>

    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <!-- CDNJS :: Sortable (https://cdnjs.com/) -->
    <script>

     var app = new Vue
     ({
	 el:'#root',
	 data:{
	     seminars:{{!seminars}},
	     rankings:{}
	 },
	 delimiters:["<{", "}>"],
	 methods:{
	     UpdateRanking:function(event, seminar){
		 this.rankings[seminar] = event.target.value;
		 if(event.target.value === "0"){
		     delete this.rankings[seminar];
		 }
	     },
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
