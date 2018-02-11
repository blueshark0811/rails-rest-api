import React from 'react';

import Form, { TextArea } from 'base_components/RootForm';
import Container from 'base_components/Container';
import ListNotice from './components/ListNotice';

// for body container
const Body = Container.extend`
  margin-bottom: 0;

  @media screen and (min-width: 768px) {
    min-height: 80vh;
    display: block;
  }
`;

// the full body dashboard component.
const BodyDashboard = () => (
  <Body>
    <Form>
      <TextArea
        row={3}
        name="noticeboard"
        placeholder="Write on the noticeboard..."
      />
    </Form>
    <ListNotice />
  </Body>
);

export default BodyDashboard;
