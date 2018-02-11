import PropTypes from 'prop-types';
import styled from 'styled-components';

const MainLeft = styled.div`
  @media screen and (min-width: 768px) {
    width: 75%;
    padding-right: 3em;
  }
`;

MainLeft.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]).isRequired
};

export default MainLeft;
