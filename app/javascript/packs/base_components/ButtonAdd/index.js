import React from 'react';
import PropTypes from 'prop-types';

import { ButtonIcon } from 'base_components/RootButton';
import IconPlus from 'react-icons/lib/md/add';

const Button = ButtonIcon.extend`
  width: 100%;
  margin-bottom: 10px;

  @media screen and (min-width: 768px) {
    padding: 8px 13px;
    width: initial;
    margin-right: 1.5em;
    margin-bottom: 0;
  }
`;

const ButtonAdd = ({ onHandlerClick, text, className }) => (
  <Button className={className} onClick={onHandlerClick}>
    <span>{text}</span>
    <i>
      <IconPlus />
    </i>
  </Button>
);

ButtonAdd.propTypes = {
  text: PropTypes.string.isRequired,
  onHandlerClick: PropTypes.func,
  className: PropTypes.string
};

export default ButtonAdd;
