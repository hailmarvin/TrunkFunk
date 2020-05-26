import {Socket} from 'phoenix';

let socket = new Socket('/socket', {params: {token: window.userToken}});

socket.connect();

const createSocket = (albumId) => {
  let channel = socket.channel(`comments:${albumId}`, {});
  channel.join()
    .receive("ok", resp => { 
      console.log("Joined Successfully", resp); 
      renderComments(resp.comments)
    }) 
    .receive("error", resp => { 
      console.log("Unable to join", resp); 
    });

  channel.on(`comments:${albumId}:new`, renderComment);
  
  document.querySelector('.comment').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;

    channel.push('comment:add', { content: content })
  });  
}; 

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });

  document.querySelector('.collection').innerHTML = renderedComments.join('');
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);

  document.querySelector('.collection').innerHTML += renderedComment;
}

function commentTemplate(comment) {
  let username = 'Anonymous';
  if (comment.user.username) {
    username = comment.user.username;
  }

  return `
      <li class="list-group-item">
      <span class="font-weight-bold font-italic user-comment text-right pr-2">${username}:</span>
        ${comment.content}        
      </li>
    `;
}

window.createSocket = createSocket