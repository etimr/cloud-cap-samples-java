namespace my.bookshop;

using {
    Currency,
    sap,
    managed,
    cuid
} from '@sap/cds/common';
using my.bookshop.Reviews from './reviews';
using my.bookshop.TechnicalBooleanFlag from './common';
using {sap.attachments.Attachments} from `com.sap.cds/cds-feature-attachments`;

@fiori.draft.enabled
entity Books : cuid, managed {
    title        : localized String(111);
    descr        : localized String(1111);
    author       : Association to Authors;
    genre        : Association to Genres;
    stock        : Integer;
    price        : Decimal(9, 2);
    currency     : Currency;
    rating       : Decimal(2, 1);
    reviews      : Association to many Reviews
                       on reviews.book = $self;
    isReviewable : TechnicalBooleanFlag not null default true;
    covers       : Composition of many Attachments;
}

annotate Attachments with @UI: {
    LineItem  : [
        {Value: content},
        {Value: fileName},
        {Value: status},
        {Value: createdAt},
        {Value: createdBy},
        {Value: note}
    ]
}

entity Authors : cuid, managed {
    @assert.format : '^\p{Lu}.*' // assert that name starts with a capital letter
    name         : String(111);
    dateOfBirth  : Date;
    dateOfDeath  : Date;
    placeOfBirth : String;
    placeOfDeath : String;
    books        : Association to many Books
                       on books.author = $self;
}

// annotations for Data Privacy
annotate Authors with
@PersonalData : { DataSubjectRole : 'Author', EntitySemantics : 'DataSubject' }
{
  ID    @PersonalData.FieldSemantics : 'DataSubjectID';
  name  @PersonalData.IsPotentiallySensitive;
}

/**
 * Hierarchically organized Code List for Genres
 */
entity Genres : sap.common.CodeList {
    key ID       : Integer;
        parent   : Association to Genres;
        children : Composition of many Genres
                       on children.parent = $self;
}
