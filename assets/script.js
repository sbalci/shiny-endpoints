Shiny.addCustomMessageHandler("path", (path) => {
  $('#show').on('click', (event) => {
    let variable = $('#variable').val();

    fetch(path + '&variable=' + encodeURIComponent(variable))
      .then(response => response.json())
      .then(data => {

        let content = data.map((el) => {
          return `<li>${el}</li>`;
        }).join('');

        $('#list').html(content);
      })
      .catch(error => {
        console.error(error);
      });

    console.log("FETCHED");
  });
});
