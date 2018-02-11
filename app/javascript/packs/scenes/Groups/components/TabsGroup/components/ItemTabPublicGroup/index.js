import React from 'react';
import PropTypes from 'prop-types';
import { map } from 'ramda';

import ListItemGroup from '../ListItemGroup';

const ItemTabPublicGroup = ({ publicGroups }) => {
  // create list your group items
  const listItemPublicGroup = map(group => {
    return (
      <ListItemGroup isJoined={group.isJoined} key={group.id} group={group} />
    );
  }, publicGroups);

  return <ul>{listItemPublicGroup}</ul>;
};

ItemTabPublicGroup.propTypes = {
  publicGroups: PropTypes.arrayOf(PropTypes.object).isRequired
};

export default ItemTabPublicGroup;
