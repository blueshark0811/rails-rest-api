import React from 'react';

import SearchbarTable, {
  SearchbarButtonFilter,
  SearchbarDropdownCourse,
  SearchbarDropdownLesson,
  SearchbarForm
} from 'base_components/SearchbarTable';
import Flagged from './components/Flagged';

const SearchbarTableCourse = () => (
  <SearchbarTable>
    <SearchbarButtonFilter title="Show All" />
    <SearchbarDropdownCourse />
    <SearchbarDropdownLesson />
    <SearchbarForm />
    <Flagged className="Flagged" />
  </SearchbarTable>
);

export default SearchbarTableCourse;
