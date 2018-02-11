import styled from 'styled-components';

// for the header container admin users.
export default styled.header`
  display: flex;
  flex-direction: column;
  border-bottom: 1px solid #dadada;
  padding: 6px 0 28px 0;
  margin-bottom: 1.5em;

  @media screen and (min-width: 768px) {
    flex-direction: row;
  }
`;
