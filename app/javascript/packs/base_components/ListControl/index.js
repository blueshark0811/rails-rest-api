import styled from 'styled-components';

const ListControl = styled.ul`
  display: flex;
  flex-direction: column;
`;

const ListItemControl = styled.li`
  display: flex;
  align-items: center;
  margin-bottom: 0.8em;

  &:last-child {
    margin-bottom: 0;
  }

  button {
    margin-right: 1.5em;
  }

  label {
    font-size: 12px;
    max-width: 325px;
  }
`;

export { ListControl as default, ListItemControl };
