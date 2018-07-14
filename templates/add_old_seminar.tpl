<!doctype html>
<html>
    <div id="root">
	<form action="add_old" method="POST" >
	    <input type="hidden" v-for="sem in added_seminars" name="added_sems" :value="sem">
	    <input type="submit" value="Save">
	</form>
	<div v-for="seminar in old_seminars" >
	    <div>
		<h3><{seminar[1]}></h3>
	    </div>
	    <div><{seminar[2]}></div>
	    <button v-on:click="AddSeminar(seminar)">Add Seminar</button>
	</div>
    </div>

    <form action="/teacher" method="GET">
	<input type="submit" value="Back">
    </form>


    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="/js/helpers.js"></script>
    <script>
     var app = new Vue
     ({
	 el:'#root',
	 data:{
	     old_seminars:{{!old_seminars}},
	     added_seminars:[]
	 },
	 delimiters: ["<{", "}>"],
	 methods:{
	     AddSeminar:function(seminar){
		 if(this.added_seminars.indexOf(seminar[0]) === -1){
		     this.added_seminars.push(seminar[0]);
		     RemoveElem(this.old_seminars, seminar);
		 }
	     }
	 }
     });
    </script>
</html>
