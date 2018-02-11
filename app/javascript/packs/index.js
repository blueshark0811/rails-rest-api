import React from 'react';
import ReactDOM from 'react-dom';

/* importing styles in our app*/
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';
import 'video-react/dist/video-react.css';
import './styles/index.css';

import Root from './scenes/Root';
import registerServiceWorker from 'utils/serviceWorker';

ReactDOM.render(<Root />, document.getElementById('root'));
registerServiceWorker();
