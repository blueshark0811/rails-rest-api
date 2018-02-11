import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import IconMenu from 'react-icons/lib/fa/align-justify';
// For panel
import withCollapsiblePanel from 'hoc/withCollapsiblePanel';
// Sub-components
import HeaderItemCourse from './components/HeaderItemCourse';
import BodyItemCourse from './components/BodyItemCourse';
import CollapsiblePanelItemCourse from './components/CollapsiblePanelItemCourse';

// container that will hold the info course
const ContainerInfoCourse = styled.div`
  width: 95%;
`;

// the menu buton
const MenuButton = styled.span`
  display: none;

  @media screen and (min-width: 768px) {
    display: inline;
    color: #e3e3e3;
  }
`;

// this is the shape of the list item course.
const ListItemCourse = ({ className, isOpenPanel, onToggle }) => (
  <li className={className}>
    <div>
      <ContainerInfoCourse>
        <HeaderItemCourse />
        <BodyItemCourse onToggle={onToggle} isOpenPanel={isOpenPanel} />
      </ContainerInfoCourse>
      <MenuButton>
        <IconMenu />
      </MenuButton>
    </div>
    <CollapsiblePanelItemCourse isOpenPanel={isOpenPanel} />
  </li>
);

ListItemCourse.propTypes = {
  isOpenPanel: PropTypes.bool.isRequired,
  onToggle: PropTypes.func.isRequired
};

// we will make the ListItemCourse as a styled component
const StyledListItemCourse = styled(withCollapsiblePanel(ListItemCourse))`
  > div:first-child {
    padding: 1.7em 0 0.8em;
    border-bottom: 1px solid #dadada;
  }

  &:first-child {
    > div:first-child {
      padding-top: 0.8em;
    }
  }

  @media screen and (min-width: 768px) {
    > div:first-child {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 2.3em 2.4em 1.5em;
    }

    &:first-child {
      > div:first-child {
        padding-top: 0.9em;
      }
    }
  }
`;

// for teacher user courses component.
const ItemTeacherUserCourses = () => (
  <ul>
    <StyledListItemCourse />
    <StyledListItemCourse />
  </ul>
);

// we will subscribe this component into hoc to make some components more collapsible.
export default ItemTeacherUserCourses;
