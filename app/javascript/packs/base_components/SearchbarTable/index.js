import PropTypes from 'prop-types';
import styled from 'styled-components';

import SearchbarButtonFilter from './components/SearchbarButtonFilter';
import SearchbarDropdownCourse from './components/SearchbarDropdownCourse';
import SearchbarDropdownLesson from './components/SearchbarDropdownLesson';
import SearchbarForm from './components/SearchbarForm';
import { $borderLightColor } from 'shared/color';

// creating styled component for searchbar container
const SearchbarTable = styled.div`
  border-bottom: 1px solid ${$borderLightColor};
  padding: 2%;
  margin-top: 3%;

  @media screen and (min-width: 768px) {
    margin-top: 0;
    padding: 27px 40px;
    display: flex;
    align-items: center;
  }
`;

SearchbarTable.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]).isRequired
};

export {
  SearchbarTable as default,
  SearchbarButtonFilter,
  SearchbarDropdownCourse,
  SearchbarDropdownLesson,
  SearchbarForm
};
