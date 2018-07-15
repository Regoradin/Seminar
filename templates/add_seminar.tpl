<div id="root">
  <form action="add" method="POST">
    <input type="text" name="title" value="Title" required>
    <input type="text" name="description" value="Description" required>
    <select name="session" required>
	<option selected disabled hidden>Select Session</option>
	<option value="1" >First Session</option>
	<option value="2" >Second Session</option>
	<option value="3" >Double Session</option>
    </select>
    <select v-for="i in teacher_count" name="teacher" required>
	<option selected disabled hidden>Select Teacher</option>
	<option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
    </select>
  
    <input type="submit" name="save" value="Add Seminar">
  </form>

  <button v-on:click="teacher_count += 1">Add Teacher</button>
  <button v-on:click="teacher_count -= teacher_count > 1 ? 1 : 0">Remove Teacher</button>
  
  <form action = "/teacher">
    <input type="submit" value="Back">
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
<script>
  var app = new Vue
  ({
  el:'#root',
  data:{
  teachers: {{!teachers}},
  teacher_count:1
  },
  delimiters:["<{", "}>"]
    })
</script>
