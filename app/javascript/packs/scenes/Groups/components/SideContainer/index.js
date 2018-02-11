import React from 'react';
import PropTypes from 'prop-types';
import { isEmpty } from 'ramda';

import SearchBar from 'base_components/RootSearchBar';
import InformationText from 'base_components/InformationText';
import { MainRight } from 'base_components/Main';

// extending the styles of right container.
const RightContainer = MainRight.extend`
  p {
    font-size: 0.88rem;
    color: #515151;
  }
  @media screen and (max-width: 767px) {
    margin-top: 1.7em;
  }
`;

// container that holds the side components.
const SideContainer = ({ groups }) => (
  <RightContainer>
    <SearchBar placeholder="Search groups" />
    {!isEmpty(groups) ? (
      <div>
        <p>Only one group can be selected (active) at a time.</p>
        <p>
          If you can’t see a group it may be invite-only. Contact your
          administrator about joining a private group.
        </p>
        <InformationText text="Learn more about groups" to="/learn-groups" />
      </div>
    ) : (
      <p />
    )}
  </RightContainer>
);

SideContainer.propTypes = {
  groups: PropTypes.array.isRequired
};

export default SideContainer;
