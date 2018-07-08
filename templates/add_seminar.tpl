<div id="root">
  <form action="add" method="POST">
    <input type="text" name="title" value="Title">
    <input type="text" name="description" value="Description">
    <input type="submit" name="save" value="Add Seminar">
    
    <select name="teacher">
      <option v-for="teacher in teachers" :value="teacher[0]"><{teacher[1]}></option>
    </select>
  </form>
  
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
  teachers: {{!teachers}}
  },
  delimiters:["<{", "}>"]
    })
</script>
