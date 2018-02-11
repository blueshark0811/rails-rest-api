import React from 'react';
import PropTypes from 'prop-types';
import { filter, identical } from 'ramda';
// for Tab Component
import { Tab } from 'react-bootstrap';
import Tabs from 'base_components/Tabs';

import ItemTabYourGroup from './components/ItemTabYourGroup';
import ItemTabPublicGroup from './components/ItemTabPublicGroup';

const TabsGroup = ({ groups }) => {
  // get the yourGroups item on the groups array.
  const yourGroups = filter(
    group => identical(group.type, 'your-group'),
    groups
  );
  // get the public groups item on the groups array.
  const publicGroups = filter(
    group => identical(group.type, 'public-group'),
    groups
  );

  return (
    <Tabs>
      <Tab eventKey={1} title="Your Groups">
        <ItemTabYourGroup yourGroups={yourGroups} />
      </Tab>
      <Tab eventKey={2} title="Public Groups">
        <ItemTabPublicGroup publicGroups={publicGroups} />
      </Tab>
    </Tabs>
  );
};
TabsGroup.propTypes = {
  groups: PropTypes.array.isRequired
};

export default TabsGroup;
