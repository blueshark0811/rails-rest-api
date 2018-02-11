import React from 'react';
import PropTypes from 'prop-types';
import { map } from 'ramda';

import ListItemGroup from '../../../ListItemGroup';

const ListYourGroup = ({ yourGroups }) => {
  // create list your group items
  const listItemYourGroup = map(group => {
    return (
      <ListItemGroup
        isSelected={group.isSelected}
        key={group.id}
        group={group}
      />
    );
  }, yourGroups);

  return <ul>{listItemYourGroup}</ul>;
};

ListYourGroup.propTypes = {
  yourGroups: PropTypes.arrayOf(PropTypes.object).isRequired
};

export default ListYourGroup;
