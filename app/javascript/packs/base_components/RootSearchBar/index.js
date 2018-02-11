import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import IconSearch from 'react-icons/lib/fa/search';

import Form from 'base_components/RootForm';

// create Input text
const TextContainer = styled.div`
  display: flex;
  align-items: center;
  border: 1px solid #e2e2e2;
  padding: 0.5em 1em;
  border-radius: 3px;
  font-size: 14px;
  width: 100%;
  margin-bottom: 1.5em;

  > span {
    font-size: 1.1rem;
  }

  > input {
    margin-left: 0.5em;
    border: 0;
    &:focus {
      outline: 0;
    }
    ::placeholder {
      color: #c0c0c0;
    }
  }
`;

const SearchBar = styled(({ className, placeholder }) => (
  <Form className={className}>
    <TextContainer>
      <span>
        <IconSearch />
      </span>
      <input name="searchbar" type="text" placeholder={placeholder} value="" />
    </TextContainer>
  </Form>
))``;

SearchBar.propTypes = {
  placeholder: PropTypes.string
};

export default SearchBar;
