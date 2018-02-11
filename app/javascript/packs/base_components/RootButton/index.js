import styled from 'styled-components';

// for background color variation
const backgroundColorVariation = props => {
  if (props.secondary) {
    return '#d8d8d8';
  } else if (props.light) {
    return 'transparent';
  } else {
    return '#338ffc';
  }
};

// for color
const fontColorVariation = props => {
  if (props.secondary) {
    return '#333333';
  } else if (props.light) {
    return '#000000';
  } else {
    return '#ffffff';
  }
};

// when hover, set a background color depending on props given
const hoverBackgroundColorVariation = props => {
  if (props.secondary) {
    return '#a2a0a0';
  } else if (props.light) {
    return '#e2e2e2';
  } else {
    return '#125eb7';
  }
};

// for hover font color variation, depending on the given props.
const hoverFontColorVariation = props => {
  if (props.secondary) {
    return '#333333';
  } else if (props.light) {
    return '#000000';
  } else {
    return '#ffffff';
  }
};

const RootButton = styled.button`
  background-color: ${backgroundColorVariation};
  opacity: ${props => (props.disabled ? '0.5' : '1')};
  color: ${fontColorVariation};
  width: ${props => (props.large ? '146px' : '104px')};
  border: ${props => (props.lightBorder ? '1px solid #979797' : '0')};
  padding: 10px 0;
  font-family: 'karla';
  font-size: 12px;
  font-weight: 800;
  text-transform: uppercase;
  border-radius: 3px;
  transition: background-color 300ms ease-in;
  pointer-events: ${props => props.disabled && 'none'};

  &:hover {
    background-color: ${hoverBackgroundColorVariation};
    color: ${hoverFontColorVariation};
  }
`;

// for button icon
const ButtonIcon = RootButton.extend`
  width: 148px;
  i {
    font-size: 1rem;
    margin-left: 0.5em;
  }
`;

export { RootButton as default, ButtonIcon };
