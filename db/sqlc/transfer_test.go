package db

import (
	"context"
	"github.com/stretchr/testify/require"
	"github.com/umang4846/simple_bank/util"
	"testing"
)

func TestCreateTransfer(t *testing.T) {
	account1 := createRandomAccount(t)
	account2 := createRandomAccount(t)

	args := CreateTransferParams{
		ToAccountID:   account1.ID,
		FromAccountID: account2.ID,
		Amount:        util.RandomMoney(),
	}

	transfer, err := testQueries.CreateTransfer(context.Background(), args)
	require.NoError(t, err)
	require.NotEmpty(t, transfer)

	require.Equal(t, args.FromAccountID, transfer.FromAccountID)

}
