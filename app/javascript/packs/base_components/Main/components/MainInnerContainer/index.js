import PropTypes from 'prop-types';

import Container from 'base_components/Container';

const MainInnerContainer = Container;

MainInnerContainer.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]).isRequired
};

export default MainInnerContainer;
