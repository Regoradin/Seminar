<!doctype html>
<html>
    <div id="root" >


	<form action="student/submit" method="POST" @submit.prevent id="form">
	    <h3>Seminar List</h3>

	    <h4>Double Period</h4>
	    <p>Remaining Points: <{remaining_points[2]}></p>
	    <div v-for="(seminar, i) in double_seminars">
		<{seminar[1]}>
		<input type="number" class="double_period"  :name="'seminar_' + seminar[0]" value="0" min="0" v-on:change="UpdateRanking($event, seminar); CheckValue($event, 3);">
	    </div>
	  
	    <h4>First Session</h4>
	    <p>Remaining Points: <{remaining_points[0]}></p>
	    <div v-for="(seminar, i) in first_seminars">
		<{seminar[1]}>
		<input type="number" class="first_session"  :name="'seminar_' + seminar[0]" value="0" min="0" v-on:change="UpdateRanking($event, seminar); CheckValue($event, 1);">
	    </div>

	    <h4>Second Session</h4>
	    <p>Remaining Points: <{remaining_points[1]}></p>
	    <div v-for="(seminar, i) in second_seminars">
		<{seminar[1]}>
		<input type="number" class="second_session"  :name="'seminar_' + seminar[0]" value="0" min="0" v-on:change="UpdateRanking($event, seminar); CheckValue($event, 2);">
	    </div>
	    
	    <input type="text" name ="student_id" value="Student ID" required>
	    
	    
	    <input type="button" value="Submit Choices" onclick="document.getElementById('form').submit()" >
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
	     first_seminars:{{!first_seminars}},
	     second_seminars:{{!second_seminars}},
	     double_seminars:{{!double_seminars}},
	     rankings:{},
	     max_points:[30, 30, 10],
	     remaining_points:[30, 30, 10]
	 },
	 delimiters:["<{", "}>"],
	 methods:{
	     UpdateRanking:function(event, seminar){
		 this.rankings[seminar] = event.target.value;
		 if(event.target.value === "0"){
		     delete this.rankings[seminar];
		 }
		 
	     },
	     CheckValue(event, session){
		 if(session === 1){
		     seminars = document.getElementsByClassName("first_session");
		 }
		 else if(session === 2){
		     seminars = document.getElementsByClassName("second_session");
		 }
		 else if(session === 3){
		     seminars = document.getElementsByClassName("double_period");
		 }
		 
		 session -= 1 //because 0 indexed and all that

		 spent_points = 0;
		 for (var i = 0; i < seminars.length; i++){
		     spent_points += parseInt(seminars[i].value);
		 }

		 Vue.set(this.remaining_points, session, this.max_points[session] - spent_points);
		 
		 if(spent_points > this.max_points[session]){
		     event.target.value = this.max_points[session] - spent_points + parseInt(event.target.value);
		     //Vue.set(this.remaining_points, session, 0);
		 }

	     }
	 }
     })

    </script>
    
</html>
