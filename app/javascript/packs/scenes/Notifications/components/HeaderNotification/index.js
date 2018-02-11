import { MainHeaderTitle } from 'base_components/Main';

const HeaderNotification = MainHeaderTitle.extend`
  display: flex;
  justify-content: flex-end;

  span {
    font-weight: 800;
    color: #c9c9c9;
    text-transform: uppercase;
    font-size: 12px;
  }

  @media screen and (min-width: 768px) {
    span {
      padding-right: 8.2em;
    }
  }
`;

export default HeaderNotification;
