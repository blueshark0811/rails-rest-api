import Container from 'base_components/Container';

const ContainerFilterableList = Container.extend`
  padding: 1% 2%;

  @media screen and (min-width: 768px) {
    min-height: 100vh;
    position: fixed;
    flex-direction: column;
    margin: 0;
    padding: 0;
    width: 45%;
    border-right: 1px solid #dadada;
  }
`;

const ContainerSearchbarList = Container.extend`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-bottom: 1px solid #dadada;
  margin-bottom: 0;

  @media screen and (max-width: 767px) {
    button,
    input {
      width: 100%;
      margin-bottom: 10px;
    }

    button:last-child {
      margin-bottom: 1.5em;
    }
  }

  @media screen and (min-width: 768px) {
    margin: 0;
    flex-direction: row;

    form {
      width: 192px;
    }

    button:last-child {
      width: 126px;
    }
  }
`;

export { ContainerFilterableList as default, ContainerSearchbarList };
