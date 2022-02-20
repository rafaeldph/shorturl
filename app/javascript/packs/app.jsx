import React from 'react';
import ReactDOM from 'react-dom';
import ShortUrlList from '../components/shortUrlList';


function App({ name }) {
  return (
    <>
      <ShortUrlList />
    </>
  );
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App name="React" />,
    document.getElementById('app'),
  )
});
