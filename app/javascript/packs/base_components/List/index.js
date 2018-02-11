import React from 'react';
import PropTypes from 'prop-types';

// import all subcomponents
import ListRow from './components/ListRow';
import ListRowLeft from './components/ListRowLeft';
import ListRowRight from './components/ListRowRight';
import './styles.css';

const List = ({ className, children }) => {
  return <ul className={className}>{children}</ul>;
};

List.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]),
  className: PropTypes.string
};

// exposed this Components.
// setting as the default component to be imported.
export { List as default, ListRow, ListRowLeft, ListRowRight };
