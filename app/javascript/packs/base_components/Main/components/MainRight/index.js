import PropTypes from 'prop-types';
import styled from 'styled-components';

const MainRight = styled.div`
  @media screen and (min-width: 768px) {
    width: 25%;
  }
`;

MainRight.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]).isRequired
};

export default MainRight;
