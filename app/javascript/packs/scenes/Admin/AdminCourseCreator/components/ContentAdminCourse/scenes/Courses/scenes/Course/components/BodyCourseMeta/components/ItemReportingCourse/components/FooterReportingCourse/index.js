import React from 'react';
// for footer
import styled from 'styled-components';
import Button from 'base_components/RootButton';
import IconWarning from 'react-icons/lib/fa/exclamation-circle';

const FooterReportingCourse = styled(({ className }) => (
  <footer className={className}>
    <div>
      <i>
        <IconWarning />
      </i>
      <span>Total mark is over - adjust weights</span>
    </div>
    <Button>Update</Button>
    <Button secondary>Preview Report</Button>
  </footer>
))`
  > div {
    margin-bottom: 1.4em;
    color: #ec0a00;

    i {
      margin-right: 0.5em;
      vertical-align: text-bottom;
    }
  }

  button {
    width: 130px;
  }

  button:last-child {
    display: block;
    margin-top: 1.1em;
  }

  @media screen and (min-width: 768px) {
    button:last-child {
      margin-top: 1.4em;
    }
  }
`;

export default FooterReportingCourse;
