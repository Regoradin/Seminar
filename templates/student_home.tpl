<!doctype html>
<html>
    <head>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/style.css">
    </head>
    <body>
	<div id="root" >


	    <form action="student/submit" method="POST" @submit.prevent id="form">
		<h3>Seminars</h3>

		<div class="sessionBox">
		    <h4>Double Period</h4>
		    <p>Remaining Points: <{remaining_points[2]}></p>
		    <div v-for="(seminar, i) in double_seminars">
			<span class="semTitle" ><{seminar[1]}></span>
			<input type="number" class="double_period"  :name="'seminar_' + seminar[0]" value="0" min="0" v-on:change="UpdateRanking($event, seminar); CheckValue($event, 3);">
			<div>
			    <{seminar[2]}>
			</div>
		    </div>
		</div>

		<div class="sessionBox">
		    <h4>First Session</h4>
		    <p>Remaining Points: <{remaining_points[0]}></p>
		    <div v-for="(seminar, i) in first_seminars">
			<span class="semTitle" ><{seminar[1]}></span>
			<input type="number" class="first_session"  :name="'seminar_' + seminar[0]" value="0" min="0"  v-on:change="UpdateRanking($event, seminar); CheckValue($event, 1);">
			<div>
			    <{seminar[2]}>
			</div>
		    </div>
		</div>

		<div class="sessionBox">
		    <h4>Second Session</h4>
		    <p>Remaining Points: <{remaining_points[1]}></p>
		    <div v-for="(seminar, i) in second_seminars">
			<span class="semTitle"><{seminar[1]}></span>
			<input type="number" class="second_session"  :name="'seminar_' + seminar[0]" value="0" min="0" v-on:change="UpdateRanking($event, seminar); CheckValue($event, 2);">
			<div>
			    <{seminar[2]}>
			</div>
		    </div>
		</div>
		    
		<input type="text" name ="student_id" value="Student ID" required>
		
		
		<input type="button" class="btn btn-primary" value="Submit Choices" onclick="document.getElementById('form').submit()" >
		<input type="reset" class="btn" value="Reset Rankings" >
	    </form>

	    
	    
	</div>

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
			 Vue.set(this.remaining_points, session, 0);
		     }

		 }
	     }
	 })

	</script>
    </body>
</html>
