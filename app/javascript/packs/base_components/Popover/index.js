import React from 'react';
import PropTypes from 'prop-types';
import {
  Popover as BootstrapPopover,
  OverlayTrigger,
  Badge
} from 'react-bootstrap';

import './styles.css';

const Popover = ({ popoverContent, buttonIcon, buttonStyle, dataCount }) => {
  // this is our popover container
  const PopoverContainer = (
    <BootstrapPopover className="Popover" id="popover-trigger-click-root-close">
      <div className="Popover__content">{popoverContent}</div>
    </BootstrapPopover>
  );
  return (
    <OverlayTrigger
      trigger="click"
      rootClose
      placement="bottom"
      overlay={PopoverContainer}
    >
      <button className="Popover__button" type="button" style={buttonStyle}>
        {buttonIcon}
        {dataCount && <Badge className="Popover__button__badge">10</Badge>}
      </button>
    </OverlayTrigger>
  );
};

Popover.propTypes = {
  popoverContent: PropTypes.element.isRequired,
  buttonTrigger: PropTypes.element.isRequired,
  dataCount: PropTypes.number
};

export default Popover;
