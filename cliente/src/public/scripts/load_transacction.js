const taskForm = document.querySelector("#taskForm");


taskForm.addEventListener("submit", e => {
    e.preventDefault()
    console.log(taskForm["title"].value, taskForm["description"].value)
    const title = taskForm["title"].value
    const description = taskForm["description"].value
    App.createTask(title, description)
})

