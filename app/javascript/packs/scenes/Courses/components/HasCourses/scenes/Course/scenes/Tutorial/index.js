import React from 'react';
import PropTypes from 'prop-types';

import Modal from './components/Modal';

const Tutorial = ({ match, history }) => {
  return (
    <div>
      <Modal history={history} />
    </div>
  );
};

Tutorial.propTypes = {
  match: PropTypes.object.isRequired,
  history: PropTypes.object.isRequired
};

export default Tutorial;
