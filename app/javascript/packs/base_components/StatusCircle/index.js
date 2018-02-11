import styled from 'styled-components';
import PropTypes from 'prop-types';

const backgroundColorState = props => {
  switch (props.state) {
    case 'active': {
      return '#2FE330';
    }
    case 'inActive': {
      return '#E82929';
    }
    case 'disabled': {
      return '#AEAEAE';
    }
    default: {
      return '#2FE330';
    }
  }
};

const StatusCircle = styled.div`
  width: 11px;
  height: 11px;
  background-color: ${backgroundColorState};
  border-radius: 50%;
  display: inline-block;
`;

StatusCircle.propTypes = {
  state: PropTypes.string
};

export default StatusCircle;
