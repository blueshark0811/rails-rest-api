import Button from 'base_components/RootButton';

export default Button.extend`
  margin-bottom: 10px;

  &:last-child {
    margin-bottom: 0;
  }

  @media screen and (max-width: 768px) {
    width: 100%;
  }

  @media screen and (min-width: 768px) {
    margin-right: 1em;
    margin-bottom: 0;
  }
`;
