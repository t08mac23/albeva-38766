// function post() {
//   const submit = document.getElementById("submit_btn");
//   submit.addEventListener("click", (e) => {
//     e.preventDefault();
//     // console.log("experiment");
//     const form = document.getElementById("comment_form");
//     const formData = new FormData(form);
//     const XHR = new XMLHttpRequest();
//     XHR.open("POST", '/drinks', true);
//     XHR.responseType = "json";
//     XHR.send(formData);
//     XHR.onload = () => {
//       const item = XHR.response.comment;
//       const html = `
//         <p class="comment-parent">
//           <strong><%= link_to ${item.user.nickname}, "/users/#{comment.user_id}", class:"comment" %>：</strong>
//           <%= link_to ${item.text},"#", class:"comment" %>
//         </p>`;
//     };
//   });
// };

// window.addEventListener('load', post);