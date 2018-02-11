import styled from 'styled-components';
import PropTypes from 'prop-types';

const Container = styled.div`
  padding: 0 2%;
  margin: 1.5em 0;

  @media screen and (min-width: 768px) {
    padding: 16px 35px;
    display: flex;
  }
`;

Container.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]).isRequired
};

export default Container;
