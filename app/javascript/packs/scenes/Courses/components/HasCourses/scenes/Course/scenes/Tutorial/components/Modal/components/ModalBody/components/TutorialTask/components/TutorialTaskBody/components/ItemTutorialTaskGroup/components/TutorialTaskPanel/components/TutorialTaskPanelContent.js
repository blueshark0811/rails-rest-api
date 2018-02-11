import React from 'react';
import PropTypes from 'prop-types';

import { Panel } from 'react-bootstrap';

const TutorialTaskPanelContent = ({ children, isPanelOpen }) => (
  <Panel collapsible expanded={isPanelOpen}>
    {children}
  </Panel>
);

TutorialTaskPanelContent.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.element),
    PropTypes.element
  ]).isRequired,
  isPanelOpen: PropTypes.bool.isRequired
};

export default TutorialTaskPanelContent;
