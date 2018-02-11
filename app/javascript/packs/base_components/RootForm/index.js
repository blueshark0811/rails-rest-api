import React from 'react';
import PropTypes from 'prop-types';

import FormGroup from './components/FormGroup';
import Label from './components/Label';
import Text from './components/Text';
import TextArea from './components/TextArea';
import {
  Checkbox,
  CheckboxCircle,
  CheckboxCircleSecondary
} from './components/Checkbox';
import Switch from './components/Switch';

const RootForm = ({ children, className }) => (
  <form className={className} action="">
    {children}
  </form>
);

RootForm.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]),
  className: PropTypes.string
};

export {
  RootForm as default,
  Text,
  TextArea,
  Checkbox,
  CheckboxCircle,
  CheckboxCircleSecondary,
  Switch,
  Label,
  FormGroup
};
