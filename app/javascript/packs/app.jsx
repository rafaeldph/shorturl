import React from 'react';
import ReactDOM from 'react-dom';
import ShortUrlForm from '../components/shortUrlForm';
import ShortUrlList from '../components/shortUrlList';


function App() {
  const copyToClipboard = (content) => {
    const el = document.createElement('textarea');
    el.value = content;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
  };

  return (
    <>
      <ShortUrlForm copyToClipboard={copyToClipboard} />
      <ShortUrlList copyToClipboard={copyToClipboard} />
    </>
  );
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App name="React" />,
    document.getElementById('app'),
  )
});
