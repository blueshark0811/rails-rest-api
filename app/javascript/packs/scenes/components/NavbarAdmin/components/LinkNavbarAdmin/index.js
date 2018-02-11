import styled from 'styled-components';
import { NavLink } from 'react-router-dom';

export default styled(NavLink)`
  color: #ffffff;
  text-transform: uppercase;
  padding: 0.7em 2%;
  display: block;
  transition: all 300ms ease-in;

  &:hover {
    color: #0e90e0;
  }

  &.active {
    background: rgba(70, 70, 70, 0.82);
    color: #0e90e0;
  }

  @media screen and (min-width: 768px) {
    font-size: 0.78rem;

    &.active {
      background: none;
    }
  }
`;
