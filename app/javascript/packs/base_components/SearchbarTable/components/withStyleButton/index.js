import styled from 'styled-components';

const withStyleButton = WrappedComponent =>
  // styling the dropdown component.
  styled(WrappedComponent)`
    background: #eeeeee;
    border: none;
    font-weight: 800;
    font-size: 12px;
    color: #969696;
    text-shadow: none;
    text-transform: uppercase;
    padding: 10px 20px;
    transition: all 300ms ease-in;
    width: 100%;

    & + .dropdown-menu {
      width: 100%;
    }

    &:active {
      color: #333333;
      background-color: #e0e0e0;
    }

    &:hover {
      color: #333333;
      background-color: #e0e0e0;
    }

    @media screen and (min-width: 768px) {
      padding: 14px 20px;
    }
  `;

export default withStyleButton;
