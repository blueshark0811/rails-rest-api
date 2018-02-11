import Container from 'base_components/Container';

export default Container.extend`
  .Tabs {
    width: 100%;
  }

  @media screen and (min-width: 768px) {
    margin-left: 45%;
    margin-top: 2px;
    width: 55%;
  }
`;
