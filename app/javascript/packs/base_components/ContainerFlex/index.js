import styled from 'styled-components';
import PropTypes from 'prop-types';

const ContainerFlex = styled.div`
  display: flex;
  flex-direction: ${props => props.isColumn && 'column'};
  align-items: ${props => props.isAlignCenter && 'center'};
  justify-content: ${props =>
    props.isSpaceBetween ? 'space-between' : 'flex-start'};
`;

ContainerFlex.propTypes = {
  isAlignCenter: PropTypes.bool,
  isSpaceBetween: PropTypes.bool
};

export default ContainerFlex;
